Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSG2KFe>; Mon, 29 Jul 2002 06:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSG2KFe>; Mon, 29 Jul 2002 06:05:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2574 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314277AbSG2KFe>;
	Mon, 29 Jul 2002 06:05:34 -0400
Message-ID: <3D45130F.6070907@evision.ag>
Date: Mon, 29 Jul 2002 12:03:59 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] partition fix
References: <UTC200207272047.g6RKl4q00901.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> The patch below does two things:
> 
> (i) fixes a small bug in the new partition code
> This is the final chunk s/n/slot/. I'll refrain from giving a vi script.
> This is uncontroversial.
> 
> (ii) removes ancient garbage concerning disk managers
> This may well be controversial.

The disk managers where kludgy garbage in first place.
And nowadays I agree with you: It's not worth to dragg it around.


