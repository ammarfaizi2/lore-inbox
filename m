Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWHAIpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWHAIpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHAIpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:45:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:54376 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750864AbWHAIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:45:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sKDUuhX+xs5CH8h46Lbblw4NpBAE1esQ/wCd0ia8D3bJSF9qJ+hc1H0SA/U3AgUcegWKpbmcAnusSWtMDewTKG2it7BPQrT7/Cxvv3VysCQGdUKgG+2R4yqi+jkP2Ud+yqg9SiGh7+ZVq3yIX0q3Zmy26RhGWZAVvZ5R1cvapFA=
Message-ID: <404c96810608010145r4c109fdet9eadba7090321048@mail.gmail.com>
Date: Tue, 1 Aug 2006 09:45:26 +0100
From: "Jonathan Matthews-Levine" <matthewslevine@gmail.com>
To: "Heiko Carstens" <heiko.carstens@de.ibm.com>
Subject: Re: do { } while (0) question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/06, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> ---
> Always use do {} while (0).  Failing to do so can cause subtle compile
> failures or bugs.
> ---
>
> I'm really wondering what these subtle compile failures or bugs are.
> Could you please explain?

http://kernelnewbies.org/FAQ/DoWhile0

cheers,
Jonathan

-- 
Jonathan Matthews-Levine
e: matthewslevine@gmail.com
