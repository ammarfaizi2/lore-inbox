Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVDASlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVDASlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVDASlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:41:08 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:61893 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262847AbVDASha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:37:30 -0500
To: linux-kernel@vger.kernel.org
Subject: [OT] Character representation in video ram when using unicode font
From: Elias Oltmanns <oltmanns@uni-bonn.de>
Date: Fri, 01 Apr 2005 19:37:31 +0100
Message-ID: <87hdiq9wd0.fsf@denkblock.local>
User-Agent: Gnus/5.1007 (Gnus v5.10.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

very sorry for bothering you with this question but I didn't know a
better place to post it to. My problem is this: As I understand, I can
load a fixed unicode font with either 256 or 512 different characters
into video rom. Now, I'd like to know how the slots and their
attributes are represented in video ram, i.e., what do I have to write
to video ram to get the character on position x of the font table
(.psf style) with attributes y on screen? Actually I only need to know
how it works for 512 characters since I've found already an
explanation for the common 256 character text mode representation.
So, if you know about any sources on the web where this technique is
specified, please tell me - I was unable to find any.

Kind regards and thanks a lot in advance,

Elias
