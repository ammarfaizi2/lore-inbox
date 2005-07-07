Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVGGWfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVGGWfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGGWdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:33:46 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:43282 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261476AbVGGWcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:32:50 -0400
Message-ID: <42CDAD94.7000306@rtr.ca>
Date: Thu, 07 Jul 2005 18:32:52 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
In-Reply-To: <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note:

hdparm can also use O_DIRECT for the -t timing test.

Eg.  hdparm --direct -t /dev/hda
