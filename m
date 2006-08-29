Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWH2HE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWH2HE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWH2HE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:04:26 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:3924 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932142AbWH2HEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:04:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eYEPRz+EstuEldtEvs1lyv6SgznF5vjy7rHznLUk65fpzQ/bzD2dUnKDJKG3ywXfFQMe2scyvd3x1EM9tJQZStmgtfiJZUm4lXuSBp3Xs/fqQO90qHNGtEvs7bcYrNx+yQUdZF3Vep4YhDNZ0xjc3OeBYQkqXTSgU8jxmA0M5Ho=
Message-ID: <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
Date: Tue, 29 Aug 2006 12:34:24 +0530
From: Niklaus <niklaus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SDRAM or DDRAM in linux
In-Reply-To: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I have access to a remote linux machine. I have a root account on it.
 I need to know whether the installed RAM is SDRAM or DDRAM.
Unfortunately i will be going to the site next month when i have to
upgrade the machine with  more capacity. Few of them are hardware
related but if you know the answer please help me.

1) How do i find out when the machine is online , if it is SDRAM or
DDRAM. I tried dmidecode utility but i was not sure about the type.
Can someone help me out by pasting the output for both DDR and SDRAM
in dmidecode or similar.

2) Can both SDRAM and DDRAM be present at a time in the same
motherboard. I mean can i have 256MB of SDRAM chip and a 256 MB of
DDRAM on the same motherboard.

If yes what are the conditions.


3) Is a motherboard designed for only one type of RAM , like if we
remove all the SDRAMs can we put DDR in it or it is either designed
for DDR or SDRAM.

Regards
Nik
