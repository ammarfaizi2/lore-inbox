Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbSLSAEk>; Wed, 18 Dec 2002 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbSLSAEj>; Wed, 18 Dec 2002 19:04:39 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:18841
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267443AbSLSAEi>; Wed, 18 Dec 2002 19:04:38 -0500
Message-ID: <3E010F07.3000708@tupshin.com>
Date: Wed, 18 Dec 2002 16:12:55 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Matthew D. Pitts" <mpitts@suite224.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via KT400
References: <001301c2a6ed$d9e7c3e0$0100a8c0@pcs686>
In-Reply-To: <001301c2a6ed$d9e7c3e0$0100a8c0@pcs686>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew D. Pitts wrote:

>Has anyone on the list used a motherboard that uses the Via KT400 AGPset? I
>just purchased a Gigabyte GA-7VAX that has it.
>
>Matthew D. Pitts
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
I'm using exactly that motherboard with no problems. There was an issue 
with DMA not being enabled on the IDE controller, but at the time, using 
kernel 2.4.19-rc2-ac3 fixed it.  I'm not sure if this fix went into 
2.4.20 or if you still need an ac kernel.

-Tupshin

