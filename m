Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSKHPOh>; Fri, 8 Nov 2002 10:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262145AbSKHPOg>; Fri, 8 Nov 2002 10:14:36 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:8719 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S262137AbSKHPOg>; Fri, 8 Nov 2002 10:14:36 -0500
Message-ID: <3DCBD66D.8090309@convergence.de>
Date: Fri, 08 Nov 2002 16:21:17 +0100
From: Holger Waechtler <holger@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Switch DVB to generic crc32.
References: <3DCBC2E3.5040503@convergence.de>  <28280.1036753951@passion.cambridge.redhat.com> <16466.1036764849@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I'm looking on the generic crc32 code right now, but need some time to 
completely understand the code. Have you checked that this code 
implements the same generator polynomial as defined in the DVB standard?

Holger

