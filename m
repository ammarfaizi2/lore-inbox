Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTAHHnF>; Wed, 8 Jan 2003 02:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAHHnF>; Wed, 8 Jan 2003 02:43:05 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:22860 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id <S267757AbTAHHnE>; Wed, 8 Jan 2003 02:43:04 -0500
Message-ID: <3E1BD88A.4080808@users.sf.net>
Date: Wed, 08 Jan 2003 08:51:38 +0100
From: Thomas Tonino <ttonino@users.sf.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Asterisk] DTMF noise
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net>
In-Reply-To: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> so - we DO NOT need a 'simplistic' DTMF decoder.

You need a good one. But good can be simplistic, is what I'm saying.

DTMF was designed to be easy to decode reliably. Complex doesn't automatically 
mean better.

I remember reading a more specific version of the message I pointed a pointer 
to, but couldn't find it back. But it came down to the devil being in the details.

It probably pays to have someone look at this with old hardware experience in 
this. Telco newsgroup perhaps.


Thomas

