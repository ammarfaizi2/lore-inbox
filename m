Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTH0W7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTH0W7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:59:52 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:31081 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262482AbTH0W7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:59:50 -0400
Message-ID: <3F4D3899.1010207@sbcglobal.net>
Date: Wed, 27 Aug 2003 18:02:49 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O18int
References: <200308222231.25059.kernel@kolivas.org> <1061592027.13091.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1061592027.13091.2.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>I have been using 2.6.0-test3-mm3 plus O18int for a whole day and I must
>say that, for me, O18int is the best I've seen until date. I dare to say
>I think it's even better than O10int.
>
I'll second that, the priority inversion issues I was having with 
2.6.0-test3-mm2 are completely gone!  I haven't been able to get any 
serious inversion issues to bring the system to its knees yet, but I'll 
keep trying.  The only difference is that I've disabled sound in order 
to use the latest kernels, but I don't think that probably had anything 
to do with the inversion problems I was running into.

And after using 2.6.0-test4 vanilla for a few hours I have a new 
appreciation for the improvements that come with Con's patches...

-Wes-

