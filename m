Return-Path: <linux-kernel-owner+willy=40w.ods.org-S514480AbUKBDD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S514480AbUKBDD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 22:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S278448AbUKBDC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 22:02:59 -0500
Received: from siaag1ae.compuserve.com ([149.174.40.7]:54768 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S314892AbUKBCyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 21:54:18 -0500
Date: Mon, 1 Nov 2004 21:50:14 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.9 USB storage problems
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411012154_MC3-1-8DBA-3D2D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 at 13:35:01 -0800 Matthew Dharm wrote:

> That should definately happen.  Along with a note that this blocks
> usb-storage from working with many devices if enabled.


  Given all the problems it would seem ub should be marked BROKEN, esp.
since it interferes with usb-storage when built.  Only way to get rid
of it is to not compile it.



--Chuck Ebbert  01-Nov-04  22:36:43
