Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbRHBOLa>; Thu, 2 Aug 2001 10:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268945AbRHBOLU>; Thu, 2 Aug 2001 10:11:20 -0400
Received: from www.transvirtual.com ([206.14.214.140]:55308 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S268941AbRHBOLL>; Thu, 2 Aug 2001 10:11:11 -0400
Date: Thu, 2 Aug 2001 07:10:55 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wheel mice on thinkpad ps/2
In-Reply-To: <20010802065332Z268824-28344+348@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10108020709210.3477-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And what of the new input-class, should all inputdevices eventually move over
> there, or just USB?

All the input devices will be moved over to the input api. We already have
input drievrs for various devices including for PS/2. 

