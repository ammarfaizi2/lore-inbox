Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752010AbWJWVWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbWJWVWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWJWVWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:22:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:56784 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752010AbWJWVWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:22:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pawuuFYYtKrrrU5YQHv8XhCKnvNJdxNgy8Hc6NsY0hCgvmLpbA+bv89TMr0bL+YzdIofRmuhd8f+pYF9QWOWUMlD1sTeu4fP4oQkzQnA0yHsFfr8aBpDv83bccIGL/eSt7XU//2xmx0yYS19TJgL7Q0qmGsK51tVgYSMiKFaZCc=
Message-ID: <c526a04b0610231422i8ed5432g71467ae26a99baa1@mail.gmail.com>
Date: Mon, 23 Oct 2006 21:22:01 +0000
From: "Adam Henley" <adamazing@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PC speaker listed as input device
In-Reply-To: <ae7121c60610231153g4a55968gf2da729c13c8f18b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ae7121c60610231153g4a55968gf2da729c13c8f18b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/06, Panagiotis Issaris <panagiotis@gmail.com> wrote:
> Hi,
>
> While trying to get my Hauppauge's remote control working, I noticed that my
> PC speaker is getting recognized as an input device. This seems very weird
> to me, is there some logic behind this?

Simple, all speakers are microphones!
(http://www.google.com/search?q=%22a+speaker+as+a+microphone%22)

Though I don't know the real reason for recognising a speaker as an
input device, this could be a "logical" explanation :o)

regards,

adam
(should probably reply to lkml as well...)
