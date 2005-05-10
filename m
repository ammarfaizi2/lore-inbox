Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVEJB2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVEJB2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEJB2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:28:33 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:7291 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261503AbVEJB2c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:28:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l2rdNmO18dkUozFxTFxMvuY0AOF/qdx6wYdPNITr/RYtt6lMAxq0dG83CkF3oYdhh7LDHvXZdIiyJhYbQ/JhAjwCjre+I+T+Ul82MLaPPd4wbCFsvoQst2btiSsgX2muYJtYpRcYqGhI4dcCA3Egbs7FClGtjh/choZK6sLBWLI=
Message-ID: <90f56e48050509182833e60705@mail.gmail.com>
Date: Mon, 9 May 2005 18:28:29 -0700
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Placing external module's object into different directory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.6.11.4 source.
I am compiling linux kernel with source
and objects are in different directory. (Using O= options)

I have an external module in different directory .
I can compile this external module without a problem.  
But objects/modules are placed into same directory as source.

Is there any way to put external modules objects/modules
into different directory? 

Thanks
Ajay
