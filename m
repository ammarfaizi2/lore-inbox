Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277742AbRJRPEy>; Thu, 18 Oct 2001 11:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277735AbRJRPEp>; Thu, 18 Oct 2001 11:04:45 -0400
Received: from mail3.panix.com ([166.84.0.167]:59347 "HELO mail3.panix.com")
	by vger.kernel.org with SMTP id <S277738AbRJRPEh>;
	Thu, 18 Oct 2001 11:04:37 -0400
From: "Roy Murphy" <murphy@panix.com>
Reply-To: murphy@panix.com
To: linux-kernel@vger.kernel.org
Date: Thu, 18 Oct 2001 11:05:10 -0500
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
X-Mailer: DMailWeb Web to Mail Gateway 2.6k, http://netwinsite.com/top_mail.htm
Message-id: <3bceefa6.3cf6.0@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Twas brillig when Keith Owens scrobe:
>EXPORT_SYMBOL_GPL 
>
>Some kernel developers are unhappy with providing external interfaces
>to their code, only to see those interfaces being used by binary only 
>modules. They view it as their work being appropriated. Whether you 
>agree with that view or not is completely irrelevant, the person who 
>owns the copyright decides how their work can be used. 

The GPL takes its strength and power from Copyright Law.  Copyright law 
allows certain exclusive rights to authors.  Among these are: 
distribution, public performance and the preparation of derivative 
works.  Copyright Law (at least in the US) reserves certain rights to 
the Public, notably the right to make Fair Uses.  Because of Fair Use, 
the statement above "the person who owns the copyright decides how 
their work can be used." is demonstrably false in a US Copyright 
context.

Some elements of authorship are copyrightable, other elements are not.  
One clear exception in US Copyright Law is "methods of operation" which 
are not copyrightable.  The canonical example of this the pattern of a 
standard transmission shift.  The pattern, intimately tied to the 
manner in which the device is used, has been standardized because its 
design could be copied and used by all manufacturers.

Exported interfaces are "methods of operation" in the sense of US 
Copyright Law.  Copyright Law affords no protection to "methods of 
operation".  The GPL, which gains its strength from Copyright Law, also 
has no rights in this area.  If a GPLed module does not want other code 
using its interfaces, they should not be exported.

This is an example of overreaching copyright control which is just as 
aggregious as CSS on DVDs.
 
