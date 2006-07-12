Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWGLRVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWGLRVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWGLRVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:21:14 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:62850 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932126AbWGLRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:21:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AC4Dd3+nNvmCk7vfbbHE3u7BF0TK4/1w7b/QV44/g737H/D2rMSW27UFkR6W0R/nFq4hE3U5bK185rbh3ZWdNTtN9lyAqhws2Q939Qk6FQlNE6rIGIfKJGeJ6M+4lU/ElvD5GOerQg65W3vSNr/sQlTNxiqcL8Mg8hKurVPniW8=
Message-ID: <c770ab230607121021k550c3d2epf6acefa8fed491a1@mail.gmail.com>
Date: Wed, 12 Jul 2006 13:21:11 -0400
From: "Johnny Lever" <johnny.lever@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI-Express AER implemetation: AER core and aerdriver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>With Arjan's comments, I changed EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.
Sorry for flooding your emailbox again. :)

I think we should have "moron-proof" review system on LKML. Simplest
way to get started is to ignore the EXPORT_SYMBOL_GPL "missionaries"
trying to 'convert' code without giving proper thought to its
implications or without ascertaining the correctness of the
conversion.

Dimwits.

Johnny
