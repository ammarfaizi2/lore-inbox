Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265587AbUFCOwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUFCOwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUFCOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:48:25 -0400
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:55307 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S265020AbUFCOnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:43:03 -0400
Date: Thu, 03 Jun 2004 16:42:38 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: fr
MIME-Version: 1.0
To: Francois Pernet <WebMonster@idsa.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: .config question
References: <s0bf4d74.020@idfw.idsa.ch>
In-Reply-To: <s0bf4d74.020@idfw.idsa.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <S265020AbUFCOnD/20040603144642Z+818@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe /boot/config-`uname -r` ?

Francois Pernet a ecrit le 03.06.2004 16:10 :

> I've got a kernel already installed in my machine (SuSe Pro 9). I would like 
> to modify something and recompile the kernel. Since it has been installed 
> from rpm, there is no .config in /usr/src/linux. Is there any way to create 
> this file from the image and modules, so i do not need to verify all my 
> config prior to change something ?
