Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSFZOXo>; Wed, 26 Jun 2002 10:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSFZOXn>; Wed, 26 Jun 2002 10:23:43 -0400
Received: from terminus.zytor.com ([64.158.222.227]:47322 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S316599AbSFZOXm>; Wed, 26 Jun 2002 10:23:42 -0400
Message-ID: <3D19CE5E.1090704@zytor.com>
Date: Wed, 26 Jun 2002 10:23:26 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc1) Gecko/20020425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24: auto_fs.h typo.
References: <200206251759.34690.schwidefsky@de.ibm.com>	<afb4im$6nl$1@cesium.transmeta.com> <je7kkm8bma.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> |> 
> |> Please change this to:
> |> 
> |> #ifndef __alpha__
> 
> What about __ia64__?
> 

Oh right, that one too...

	-hpa




