Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTEOMja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTEOMj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 08:39:29 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:10659 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S263986AbTEOMj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:39:28 -0400
Message-ID: <3EC38D7C.1020108@inet6.fr>
Date: Thu, 15 May 2003 14:52:12 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcin@MWiacek.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SiS IDE patch] various fixes
References: <000601c31adb$2e8bf4f0$400063d9@marcin>
In-Reply-To: <000601c31adb$2e8bf4f0$400063d9@marcin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Wiacek wrote:

>I wanted to check if very carefully (Sis 655). DMA seems to be enabled
>for HDD. But still there are some problems OR with 2.4.21 at all (I
>quess something wrong generally in IDE support) OR still with Sis
>driver. Why ? It seems, that DMA is NOT enabled for DVD and CDRW. I hear
>it - they work very slow. Also hdparm shows errors, when get info about
>them. In attachments examples.
>

Please, send us your exact kernel version and the .config file used to 
make your kernel.

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 


