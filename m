Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVETJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVETJOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 05:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVETJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 05:14:50 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:10022 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVETJOs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 05:14:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vtmpo/kVKps1CftJbm6XlQMl53DHcvwKk6PQcW+Q3dAdlZnDiBz/cMGndOQSyuvuJT3J9DbhFlm03F4Mlkyk+F4wDWSGRV1c7BcPKxkamvM9ogHI3vLRGK2ZRhyB/qwZDo9Zvvhvu2oY0qHyJu7jsMoXWJPS4a8rUoIbcumY9Kw=
Message-ID: <d14685de050520021439e48c8d@mail.gmail.com>
Date: Fri, 20 May 2005 11:14:47 +0200
From: sylvanino b <sylvanino@gmail.com>
Reply-To: sylvanino b <sylvanino@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: questions about system function: mmap / fwrite
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question about ways of accessing a file. 

I know it is possible to use: fseek + fwrite/fread to access a file.
and It is also possible to map file in memory with  "mmap" function,
and access it by adressing memory.

Currently I use the frame buffer of  mobile phones with mmap function.
For my understanding, I would like to know what is the difference
between using fseek+fwrite compared to mmap style.
Dont hesitate to be precise or to use technical terms.

Thanks you,

Sylvanino
