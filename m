Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJ1U4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJ1U4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:56:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:31160 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261342AbTJ1U4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:56:13 -0500
Message-ID: <3F9ED7EB.6070800@namesys.com>
Date: Tue, 28 Oct 2003 23:56:11 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norman Diamond <ndiamond@wta.att.ne.jp>
CC: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results get worse
References: <785F348679A4D5119A0C009027DE33C105CDB39B@mcoexc04.mlm.maxtor.com> <3cba01c39c6f$141529a0$24ee4ca5@DIAMONDLX60>
In-Reply-To: <3cba01c39c6f$141529a0$24ee4ca5@DIAMONDLX60>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So it turns out that reiserfstune currently can mark bad blocks  for 
unmounted filesystems, and that the patches that were not uptodate were 
just patches for doing it for mounted filesystems.  So, problem is found 
to have already been solved after much miscommunication, sorry about that.

-- 
Hans


