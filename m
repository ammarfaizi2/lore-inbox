Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbTDTSoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTDTSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:44:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263674AbTDTSoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:44:13 -0400
Message-ID: <3EA2ED42.2000203@pobox.com>
Date: Sun, 20 Apr 2003 14:56:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpt366.c compilation fix
References: <UTC200304201823.h3KINFi18073.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304201823.h3KINFi18073.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> Remove declaration of unused variables.


Would you be open to changing your $subject in the future?

I think it is a bit misleading to call warning fixes "compilation 
fixes", because by definition warnings to not break compilation, 
therefore you are not fixing compilation :)

	Jeff



