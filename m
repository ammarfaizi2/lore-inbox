Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbRE3I2G>; Wed, 30 May 2001 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbRE3I14>; Wed, 30 May 2001 04:27:56 -0400
Received: from t2.redhat.com ([199.183.24.243]:25841 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262653AbRE3I1l>; Wed, 30 May 2001 04:27:41 -0400
Message-ID: <3B14AEFC.B522A7B4@redhat.com>
Date: Wed, 30 May 2001 09:27:40 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: anuradha@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Generating valid random .configs
In-Reply-To: <Pine.LNX.4.21.0105301102560.282-100000@presario>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha Ratnaweera wrote:
> 
> Recently, I posted a request here to send your .config files and I
> received a good number of them. (thanks!).
> 
> Now I want to generate even more different configurations, and a random
> .config generator would be ideal. If I write a program which randomly
> outputs "y", "m" and "n" and pipe its output through make config, will the
> generated .configs always compile? Yes. the best thing is to go ahead and
> try it (which I am doing at the moment) but I like to know the theoretical
> answer;)

Every once in a while I run this and fix everything that doesn't
compile. It has been 
2 months since I last did that, so I should do it again soon..

Greetings,
   Arjan van de Ven
