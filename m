Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S136113AbRD0RIu>; Fri, 27 Apr 2001 13:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S136122AbRD0RIk>; Fri, 27 Apr 2001 13:08:40 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:56657 "EHLO lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP id <S136113AbRD0RIe>; Fri, 27 Apr 2001 13:08:34 -0400
Date: Fri, 27 Apr 2001 13:08:34 -0400
From: "Michael K. Johnson" <johnsonm@redhat.com>
Message-Id: <200104271708.f3RH8Yv02001@bastable.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lid support for ACPI
References: <4148FEAAD879D311AC5700A0C969E89006CDDDC9@orsmsx35.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>PS: This seems very strange. What if machine is so crashed so that it
>can no longer shutdown properly. Will that mean that its CPU will
>damage itself?

No, the ACPI standard requires CPUs to shut themselves down before
any damage would occur from overheading.  Well, at least the 1.0b
version of the standard did; I haven't read 2.0 yet.

michaelkjohnson

 "He that composes himself is wiser than he that composes a book."
 Linux Application Development                     -- Ben Franklin
 http://people.redhat.com/johnsonm/lad/
