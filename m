Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWBIQcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWBIQcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBIQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:32:10 -0500
Received: from mail.gmx.net ([213.165.64.21]:42376 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932593AbWBIQcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:32:09 -0500
X-Authenticated: #428038
Message-ID: <43EB6E86.2040708@gmx.de>
Date: Thu, 09 Feb 2006 17:32:06 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: lkml@dervishd.net, peter.read@gmail.com, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca> <43EB1988.nail7EL2I7AN6@burner> <20060209145740.GB94@DervishD> <43EB62CA.nailCFH31KKTA@burner>
In-Reply-To: <43EB62CA.nailCFH31KKTA@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> DervishD <lkml@dervishd.net> wrote:
> 
>>     Could you please clarify which things are broken by Matthias
>> patch? This way he (or other developer) can prepare a better patch
>> and maintain it. BTW, I patched my cdrecord with Matthias patch and
>> nothing seems to be broken :? Maybe am I missing something?
> 
> It is completely broken and thus makes no sense at all.

"Completely broken" is not a proper description that might become the basis
of a technical discussion.

It looks like the quick way of not having to look at it, at least there is
no hint you could provide specific information as to what the patch breaks.
