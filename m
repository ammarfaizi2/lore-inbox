Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319131AbSH2H4N>; Thu, 29 Aug 2002 03:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319135AbSH2H4N>; Thu, 29 Aug 2002 03:56:13 -0400
Received: from [62.70.77.106] ([62.70.77.106]:17062 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S319131AbSH2H4N> convert rfc822-to-8bit;
	Thu, 29 Aug 2002 03:56:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
Date: Thu, 29 Aug 2002 10:00:46 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200208281128.28256.roy@karlsbakk.net> <238727922.1030523435@[10.10.2.3]>
In-Reply-To: <238727922.1030523435@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208291000.46618.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Summary: the code below probably isn't the desired solution.

Very well - but where is the code to run then?

I mean - this code solved _my_ problem. Without it the server OOMs within 
minutes of high load, as explained earlier. I'd rather like a clean fix in 
2.4 than this, although it works.

Any thougths?

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

