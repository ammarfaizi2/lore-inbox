Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277774AbRJRPnr>; Thu, 18 Oct 2001 11:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277756AbRJRPni>; Thu, 18 Oct 2001 11:43:38 -0400
Received: from mail1.panix.com ([166.84.0.212]:60610 "HELO mail1.panix.com")
	by vger.kernel.org with SMTP id <S277751AbRJRPnU>;
	Thu, 18 Oct 2001 11:43:20 -0400
From: "Roy Murphy" <murphy@panix.com>
Reply-To: murphy@panix.com
To: Arjan van de Ven <arjanv@redhat.com>, Roy Murphy <murphy@panix.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 18 Oct 2001 11:43:15 -0500
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
X-Mailer: DMailWeb Web to Mail Gateway 2.6k, http://netwinsite.com/top_mail.htm
Message-id: <3bcef893.4872.0@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Twas brillig when Arjan van de Ven scrobe:
>I think you're missing one thing: binary only modules are only allowed
>because of an exception license grant Linus made for functions that are
>marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of 
>this exception grant"....

With all respect to Linus, I don't believe that module insertion is an 
exclusive right granted to authors that is within Linus' legal power as holder
of the Copyright to the kernel to grant or to restrict.  Does Microsoft have
a legal right to disallow any third-party drivers from 
registering themselves with the OS?  Does Linus?
 
