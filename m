Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSDKUWK>; Thu, 11 Apr 2002 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDKUWJ>; Thu, 11 Apr 2002 16:22:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:25851
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312901AbSDKUWF>; Thu, 11 Apr 2002 16:22:05 -0400
Date: Thu, 11 Apr 2002 13:24:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com, akpm@zip.com.au,
        buytenh@gnu.org
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020411202416.GN23513@matchmail.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
	akpm@zip.com.au, buytenh@gnu.org
In-Reply-To: <20020411004911.GH23513@matchmail.com> <20020411010515.GI23513@matchmail.com> <20020411014035.GJ23513@matchmail.com> <20020410.194411.48882878.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 07:44:11PM -0700, David S. Miller wrote:
>    From: Mike Fedyk <mfedyk@matchmail.com>
>    Date: Wed, 10 Apr 2002 18:40:35 -0700
> 
>    On Wed, Apr 10, 2002 at 06:05:15PM -0700, Mike Fedyk wrote:
>    > 2.4.19-pre6-nobr0fpsh building now...
>    
>    Yep, reversing 2.4.18_fix_port_state_handling.diff fixed it.
> 
> Thanks for tracking this down so precisely.  If every bug reporter
> actually bothered to do this work, it'd take a lot less work to
> fix most bugs :-)
>

Thanks. :)

> Lennert, just let me know when you have a fix :-)
> 

Couldn't have done it if Lennert didn't keep those applied patches
available, and separated. :)

Mike
