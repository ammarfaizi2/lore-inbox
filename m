Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTJTPzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTJTPzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:55:17 -0400
Received: from mcomail03.maxtor.com ([134.6.76.14]:56338 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S262686AbTJTPzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:55:12 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB30C@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Hans Reiser'" <reiser@namesys.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results are in
Date: Mon, 20 Oct 2003 09:55:07 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Hans Reiser [mailto:reiser@namesys.com]
> Sent: Sunday, October 19, 2003 2:25 AM
> To: Norman Diamond
> Cc: Mudama, Eric; 'Wes Janzen '; 'Rogier Wolff '; 'John Bradford ';
> linux-kernel@vger.kernel.org; nikita@namesys.com; 'Pavel Machek ';
> 'Justin Cormack '; 'Russell King '; 'Vitaly Fertman '; 
> 'Krzysztof Halasa
> '
> Subject: Re: Blockbusting news, results are in
> 
> 
> Norman Diamond wrote:
> 
> >
> >>What would you like "us disk makers" to say?
> >>    
> >>
> >
> >How to force reallocations even when data are lost, 
> >
> buy Maxtor and write to them, thereby triggering the remap.

It isn't necessarilly that simple.  However, if the drive is still alive, it
has written your data to a place where it can get at it again.  
