Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWD3Rgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWD3Rgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWD3Rgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:36:35 -0400
Received: from nproxy.gmail.com ([64.233.182.190]:6227 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751204AbWD3RgD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:36:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2P7puHPzEpHhsUNmymuLPbQRdKvcoIEYL0x+JfQkisFteMaG6RKwjN3bV5PWo0CiAt71Q0evkU5KRbOeExzx8sibvHDIyKA9pMQu6O0Yh4WCtpL7DpMNdVZsKrFPzYCkKgxYUdrUQTqD1LbtAoyZbAjyAb22wHlSS6102Z5ubM=
Message-ID: <7115951b0604301036h3962ddbfs5a60c93a130c50a0@mail.gmail.com>
Date: Mon, 1 May 2006 00:36:02 +0700
From: "Dmitry Fedorov" <dm.fedorov@gmail.com>
To: "Christian Trefzer" <ctrefzer@gmx.de>
Subject: Re: [FYI] whitespace removal
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060430172716.GC17917@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060430172716.GC17917@zeus.uziel.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/5/1, Christian Trefzer <ctrefzer@gmx.de>:

> Granted, for one line that has its whitespace removed we get
> roughly eight lines in the diff, so this is mostly bloat.

Use "diff -b".
