Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTJSIY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJSIY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:24:58 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:63398 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262094AbTJSIYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:24:54 -0400
Message-ID: <3F924A54.7020502@namesys.com>
Date: Sun, 19 Oct 2003 12:24:52 +0400
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
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com> <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
In-Reply-To: <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:

>
>>What would you like "us disk makers" to say?
>>    
>>
>
>How to force reallocations even when data are lost, 
>
buy Maxtor and write to them, thereby triggering the remap.

All of this said, let me just repeat that I concede that ReiserFS does 
need to support remapping, and Reiser4 does it.  However, I think that 
we should encourage users to ask the drive to do it for them.  Maybe 
this is wrong if it turns out that most drives are not responsible/wise 
about it, but I need more info before I can say about that.

-- 
Hans


