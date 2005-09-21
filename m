Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIUCza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIUCza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 22:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIUCza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 22:55:30 -0400
Received: from web88003.mail.re2.yahoo.com ([206.190.37.190]:42165 "HELO
	web88003.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750725AbVIUCza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 22:55:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SJx3BQ/vNizIZqwsIGYoMwZ0wHz+kOOY3zMMdHRXkOC/RBft0qvWGrnRDVwzjYy+jibQXgKwGXoVmEvRjyjpO7syFZZtz7KawNFpAM6SU/YjGh+rFWYPp47kumd4pKEYRa/VILJfCqQ5E0TkZLWwS12bBSRg6zTGGvKo7G1EsZ4=  ;
Message-ID: <20050921025521.88180.qmail@web88003.mail.re2.yahoo.com>
Date: Tue, 20 Sep 2005 22:55:21 -0400 (EDT)
From: Christopher Prest <christopher.prest@rogers.com>
Subject: Re: In-kernel graphics subsystem
To: Athar Hameed <06020051@lums.edu.pk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2CB9FE03B6DBB54AAD7193A44499D6242C9B96@satluj1.lums.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would say no.  Maybe a better idea would be to
extend the current OpenGL lib and provide an API layer
for creating a set of rich graphics functionality in
"regular" applications.  I.e. 3d charts, buttons, 3d
form space ?

Just a suggestion.


--- Athar Hameed <06020051@lums.edu.pk> wrote:

> Hi,
> 
> We are a group of three undergrad CS students,
> almost ready to start our senior project. We have
> this idea of integrating a graphics subsystem with
> the kernel and doing away with the X server. We are
> not really sure if this is a wise thing to do. It
> hasn't been done before. Your comments on this idea
> will be very helpful.
> 
> 
> Thanks,
> 
> Athar
> Shery
> Kazi
> 
> P.S. We are not subscribed to the lklm. Kindly CC
> your replies to 06020051@lums.edu.pk
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

