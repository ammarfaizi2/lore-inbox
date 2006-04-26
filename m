Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWDZN4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWDZN4K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWDZN4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:56:09 -0400
Received: from wproxy.gmail.com ([64.233.184.225]:56304 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932449AbWDZN4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:56:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gVyTC1Wm/GIWWtT1zWjMKvJtYbdCRuppbQoRvO2WxhsiPyobGXmYVXG81G/KHvIZ/meBxaa5cAYGnFSwR537udzhg8orJMZZlsSWXlUDDH6NPUPKUyFKurpBfb3CuOa1YkiEzLGO+Wo0lWKYUHyeVAgT2PKA5CJC8SkySnO3xG8=
Message-ID: <bbe04eb10604260656h76064baev4f654a929290d35b@mail.gmail.com>
Date: Wed, 26 Apr 2006 09:56:06 -0400
From: "Kimball Murray" <kimball.murray@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <200604261517.06505.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
	 <200604261517.06505.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,



On 4/26/06, Andi Kleen <ak@suse.de> wrote:
> On Tuesday 25 April 2006 21:53, Brown, Len wrote:
> > I'd rather see the original irq-renaming patch
> > and its subsequent multiple via workaround patches
> > reverted than to further complicate what is becoming
> > a fragile mess.
>
> Sorry rechecking - i already got the patch now. You want me to drop it again?
>
> I guess we could drop it all, but VIA must still work afterwards.
> How would we do that?
>
> -Andi
>
