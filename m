Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTJDUHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbTJDUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:07:04 -0400
Received: from nan-smtp-06.noos.net ([212.198.2.75]:6441 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S262746AbTJDUHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:07:03 -0400
Message-ID: <3F7F2896.80004@free.fr>
Date: Sat, 04 Oct 2003 22:07:50 +0200
From: ph75 <ph75@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en, fr-fr, fr
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
CC: Erik Andersen <andersen@codepoet.org>
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility
 ?
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org> <20031004192733.GA30371@gtf.org>
In-Reply-To: <20031004192733.GA30371@gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Oh yeah, when ICH5 SATA is configured to native mode, "lspci -vvvxxx"
>output -- when run as root -- would be helpful as well.
>
You can show extended lspci output at http://plochon.free.fr/lspci.txt
IDE Bios setting sets to "Enhanced mode" (what you call "native mode" I 
presume),
but without "noapic" flag (with "nopic" it  won't  boot).

Philippe

