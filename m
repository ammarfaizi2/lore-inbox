Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031587AbWLAUdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031587AbWLAUdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031612AbWLAUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:33:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:45519 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031587AbWLAUdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:33:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SHWdYsOGebNXk6hcxM4eltScYaWFMeqqG70ddLDTgdY4e68J7xHWR7lCYLg9qBb7Gs37k9tU9TZU4xOrw/MEgNvwBCeBTlvXvjVhGDkHw9mnguv097A9c2MjBfkqyolBwhcJHw+k5nwZUp6q3JmcjeEtM7oarI40XzZeebi4cDE=
Message-ID: <feed8cdd0612011233i544d196x5bba1a6f6ce653bb@mail.gmail.com>
Date: Fri, 1 Dec 2006 12:33:08 -0800
From: "Stephen Pollei" <stephen.pollei@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
Cc: "Hua Zhong" <hzhong@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       tigran@aivazian.fsnet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <1164964119.3233.56.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <00e401c7150e$061da500$6721100a@nuitysystems.com>
	 <1164964119.3233.56.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2006-11-30 at 22:00 -0800, Hua Zhong wrote:
> > I am curious, what's the point?
> >
> > These email addresses serve a "historical" purpose: they tell when the contribution was made,  what the author's email addresses
> > were at that point.

Approximately when I wish the copyright dates were comma separated
iso8601 date ranges myself.
I also am not likely to typically care what their email address was
then, I want current information in the current kernel sources.
If I want old email address I got old tarballs I can get at least.

> .. and which company owns the copyright.

Not in the USA according to http://www.copyright.gov/title17/92chap4.html#401 .
[[ ... § 401. Notice of copyright: Visually perceptible copies ...
b) Form of Notice. — If a notice appears on the copies, it shall
consist of the following three elements:

(1) the symbol (c) (the letter C in a circle), or the word
"Copyright", or the abbreviation "Copr."; and

(2) the year of first publication of the work; in the case of
compilations or derivative works incorporating previously published
material, the year date of first publication of the compilation or
derivative work is sufficient. The year date may be omitted where a
pictorial, graphic, or sculptural work, with accompanying text matter,
if any, is reproduced in or on greeting cards, postcards, stationery,
jewelry, dolls, toys, or any useful articles; and

(3) the name of the owner of copyright in the work, or an abbreviation
by which the name can be recognized, or a generally known alternative
designation of the owner. ]]

For source code generally there are a few changes for typical copyright notices:
They use "Copyright (C)" because ASCII and EBCDIC didn't have native
copyright symbol like unicode does now.
They include years in which they were published and not just the first
year in which in this version was published.
The name of copyright owner typically also includes an email address.

Copyright (C) 1999,2000 Tigran Aivazian <tigran@veritas.com>
Copyright (C) 1999 Tigran Aivazian <tigran@veritas.com>
etc seems like only copyright notices changed effect Tigran and if
Tigran meant for it to be copyrighted by veritas he would have done
Copyright (C) 1999 Veritas Inc. http://www.veritas.com/
However he did not do so.

Of course I'd prefer something closer to
Copyright (C) 1999-07-05/2000-03-12 Tigran Aivazian
<tigran@aivazian.fsnet.co.uk>
or at least
Copyright (C) 1999-07-05/2000-03 Tigran Aivazian <tigran@aivazian.fsnet.co.uk>

Especially if the laws ever get changed to make copyright durations
shorter. Like 14 years instead of 50 years ,70 years, or as old as
Disney's Steam Boat Willie.

>
> Lets not remove historical email addresses. Just make sure there's a
> current one in MODULE_AUTHOR / MAINTAINERS.

I think whoever should either remove or update the email addresses.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
