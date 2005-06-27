Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVF0TgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVF0TgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVF0TgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:36:01 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:61018 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261171AbVF0TfP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:35:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a+CsImpJcepJTubZd9ldsKFxd1FA7eIfCIzg3CkXyI44yT4fZrnJTL8NW1MxsUmjdVA1m8uh9+1Z4SOFT6fhnRCD1S9C5asDuEisFH1OvMCtxUjCsB8gWdQVtCt2RZguThFADzRF0IwsgJ+RTbim0ovtCaLYTHZ1CVvGHETMaAA=
Message-ID: <105c793f050627123583a70d0@mail.gmail.com>
Date: Mon, 27 Jun 2005 15:35:10 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Jim serio <jseriousenet@gmail.com>
Subject: Re: 2.6.X not recognizing second CPU
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3642108305062711524e1e163@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3642108305062711524e1e163@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tried ... force=acpi...
All I can suggest is acpi=force, unless this was a typo, in which
case, sorry for wasting your time.

-Andy
