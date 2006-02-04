Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWBDK3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWBDK3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWBDK3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:29:48 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:59813 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751183AbWBDK3r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:29:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ETiEWlf567qiA1H4V1F4i7CcxZ7JRxtby0TjFmQVJ9hQJbNKSAEbKCtUggQkCDSVkHrEeU0qtxU5Mr5q25LFBVBAN3+mVNYWncGJkq0oQ10FDTn2NrNpIHJV55QKe3Qg0HRWUspBHkpcNR2cU/h3vUwL3bA1Fkn86Kkvfz9b/B8=
Message-ID: <8b12046a0602040229q4a44406fnbf61613240c97975@mail.gmail.com>
Date: Sat, 4 Feb 2006 10:29:42 +0000
From: Subodh Shrivastava <subodh.shrivastava@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, In kernel swsusp code works for me (over multiple boots) no
sluggishness in X after resume. Below are the details.

shannah ~ # uname -a
Linux shannah 2.6.16-rc1 #1 PREEMPT Sun Jan 29 18:39:42 GMT 2006 i686
Intel(R) Pentium(R) M processor 1300MHz GenuineIntel GNU/Linu

lspci -vvv is available on request.

Regards
--
Subodh
