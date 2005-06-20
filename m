Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVFTWM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVFTWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVFTWLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:11:24 -0400
Received: from web32106.mail.mud.yahoo.com ([68.142.207.120]:6794 "HELO
	web32106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261694AbVFTVuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:50:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5H8zxtDqK0VeT+/epGF+Az7APCddMcN+yObG7ehMH6StE9CAYmvjZy1wBJ+q+CjbgzGIXVEhyahorX9ulXIYhGh60617ljzBVZ48XZjVc8yqmiQoIJ1YxMFcxCeEsSb8Vh+lKL4Y7ouxbMvJGUR0Djg6A/VF7iQIimfXQDJ+a94=  ;
Message-ID: <20050620214951.35798.qmail@web32106.mail.mud.yahoo.com>
Date: Mon, 20 Jun 2005 14:49:51 -0700 (PDT)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Re: Announce loop-AES-v3.0d file/swap crypto package
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42B42E3B.DDEFE309@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey guys,

I am trying to write a client server application
wherein all the messages between the client and server
are encrypted. 

Just to get this whole things started lets say that I
established a shared secret between the communicating
entities. 
What is the best way to make this work. By this I mean
what is the best crypto API that I can use. I think
just for this purpose Openssl is overkill don't you
think. What kind of crypto API's can I incorporate
into my program to encrypt the message which is then
sent to the server. 

Thanks,
Vinay


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
