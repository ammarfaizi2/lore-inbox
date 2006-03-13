Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWCMJXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWCMJXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWCMJXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:23:36 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:51120 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S932382AbWCMJXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:23:35 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
To: Johannes Goecke <goecke@upb.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Mon, 13 Mar 2006 10:23:06 +0100
References: <5Pi6J-1yd-1@gated-at.bofh.it> <5PpKN-48S-7@gated-at.bofh.it> <5PQ8u-qa-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FIjGd-0000tI-Nu@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Goecke <goecke@upb.de> wrote:

> PS:
> can someone give me a (kernel-programming-beginner-level) hint, for the first
> question how to ensure to only execute if running on the right Mother-board?
> Af far as I believe the quirk so-far only checks the cipset, so it might
> behave wrong on other Mainborads!

Can you check a string in the BIOS?
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
