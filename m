Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCDFpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCDFpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVCDFpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:45:13 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:60521 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVCDFpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:45:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=KTVepUVzKHrx9aQ1KynO7k2PUsEuiMD4iwM6E9aPdYXCXO9pxPvFzHeXmdww09+r5aOk3Kk6TBdKMoblOxcQrsvdVUNkMpqh9bWz0Gm3hlKo29lfpO4M7caTjZPWiZKkNfnevAyMA0jw1u/6tUI6Qj1lBrNiLSfVEcRS1vBFVgI=
Message-ID: <c4b38ec405030321452996b084@mail.gmail.com>
Date: Fri, 4 Mar 2005 13:45:10 +0800
From: David L <abcd.bpmf@gmail.com>
Reply-To: David L <abcd.bpmf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Does linux kernel support little-endian on powerpc?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I know toolchain support the target powerpcle-elf. it enable the
little-endian on powerpc. I see that there is -melf32ppc param for ld
in arch/ppc/Makefile. Can I modify it to -melf32lppc? what will occur?
Can kernel suport little-endian on powerpc well?

thanks
Jason
