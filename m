Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314361AbSEFLPr>; Mon, 6 May 2002 07:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSEFLPq>; Mon, 6 May 2002 07:15:46 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:53121 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314361AbSEFLPp>; Mon, 6 May 2002 07:15:45 -0400
Message-ID: <3CD665A0.2030508@wanadoo.fr>
Date: Mon, 06 May 2002 13:14:40 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hch@infradead.org
CC: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.14 OSS emulation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From ChangeLog-2.5.14 :

<hch@infradead.org> (02/05/05 1.545)
	[PATCH] fix config.in syntax errors.
        - sound uses a bool where it should use a dep_bool

This prevents using OSS emulation with ALSA drivers. What is the reason 
behind ?


Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

