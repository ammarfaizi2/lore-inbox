Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUAFPbH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUAFPbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:31:06 -0500
Received: from main.gmane.org ([80.91.224.249]:11244 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264540AbUAFPbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:31:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: LVM 2.6 compatibility?
Date: Tue, 06 Jan 2004 16:31:01 +0100
Message-ID: <yw1xoethw0ui.fsf@ford.guide>
References: <1073397568.29659.178.camel@roy-sin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:bia59lhG59kbuUayw0zBmVskqVw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:

> hi all
>
> I have this archive server running 2.4 and LVM across two 3ware hardware
> RAID-5 sets with 8 drives each. Now, upgrading the server, I want a new
> logical volume >2TB so I need 2.6. But - one of the logical volumes
> would be very nice to keep. Can I upgrade to 2.6 and keep the old LV?

Yes.  LVM2 understands the LVM1 metadata format.

-- 
Måns Rullgård
mru@kth.se

