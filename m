Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290953AbSBFXmi>; Wed, 6 Feb 2002 18:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290958AbSBFXm0>; Wed, 6 Feb 2002 18:42:26 -0500
Received: from smtp.comcast.net ([24.153.64.2]:16591 "EHLO mtaout03")
	by vger.kernel.org with ESMTP id <S290961AbSBFXle>;
	Wed, 6 Feb 2002 18:41:34 -0500
Date: Wed, 06 Feb 2002 18:42:17 -0500
From: Brian <hiryuu@envisiongames.net>
Subject: Re: ?????????????????????
In-Reply-To: <2094646627.1013034678@[195.224.237.69]>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Message-id: <0GR400HBLXT5DU@mtaout03.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <0GR400G9IRB2XW@mtaout03.icomcast.net>
 <2094646627.1013034678@[195.224.237.69]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 February 2002 05:31 pm, Alex Bligh - linux-kernel wrote:
> like
>
> Subject: [ANNOUNCE] blah blah?
>

That would be upperCASE ACSII.
I mean 6 bytes, each higher than 127, in a row.

To my knowledge, there is no English word that would match that regex (or, 
for that matter, any Romantic or Germanic language word).  It's the most 
effective tool I've seen against Asian spam (like the one I replied to).

> --On Wednesday, 06 February, 2002 4:21 PM -0500 Brian
>
> <hiryuu@envisiongames.net> wrote:
> > Can we get something like
> > 	/[\200-\377]{6}/   (6 upper ACSII characters in a row)
> > added to the taboo list?
> >
> > 	-- Brian
>
