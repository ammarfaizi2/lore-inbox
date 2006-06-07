Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWFGV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWFGV7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWFGV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:59:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:36808 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932416AbWFGV7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:59:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bL3838VJWCp5LPP01jT8YwZFQ2N2JOY7QacNzo8Nie4eu81MD8ybBlvxCD6llQr4DMAYIQEeFRjioXmXQs1e+G1ZdbZ5WuAzy+wBcJXOGcMlARRZgby2IdXot029rAKAL1DVnpn7HNUTiBa2P9lrFidX/kWWs8IqnqmXd36VZs0=
Message-ID: <4d8e3fd30606071459k3410a5dbmacdea5d2b3552f00@mail.gmail.com>
Date: Wed, 7 Jun 2006 23:59:28 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Linux kernel development
Cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
In-Reply-To: <200606062210.k56M9u7f008189@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606061222l3567ed46td1c9c772ab57c056@mail.gmail.com>
	 <200606062210.k56M9u7f008189@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
 > But don't push out generated files, better add a Makefile to (re)generate
> them.

Just did :-)

Changes in the last 3 days:
Paolo Ciarrocchi:
      Added GPLv2 as the licence of this document
      Add an header with GPLv2 information
      First take at making the document asciidoc friendly
      Added a html version from asciidoc
      Further asciidoc changes
      Further asciidoc changes
      Added a newline
      Added a Makefile
      Removed the .html file, for building it just type:
      fixed a small cosmetic issue
      Added support of links in the hmtl file

So now you can simply type:
$make html
to generate the html version
$make clean
to delete it

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
