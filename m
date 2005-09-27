Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVI0Le6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVI0Le6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 07:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVI0Le6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 07:34:58 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:29498 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964902AbVI0Le6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 07:34:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ieADyAW0PtstnNrggWFQeuYEIpeaJ5CTZm3tm6bZpjhjyFgcMVz1ftYxXvjo4OKMWUyNL025hVwIAlqX+dfSmVcaVVqZe0+B0a3kioscJNkML0YKPJ8MBDUlS1oF2GusyEzyvIamEHzSBc4Znhj1ZeJi6KN7s3weMyVbzwWImkI=
Date: Tue, 27 Sep 2005 13:34:47 +0200
From: Diego Calleja <diegocg@gmail.com>
To: =?ISO-8859-15?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-Id: <20050927133447.c3caeb25.diegocg@gmail.com>
In-Reply-To: <20050927111038.GA22172@ime.usp.br>
References: <20050927111038.GA22172@ime.usp.br>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 27 Sep 2005 08:10:39 -0300,
Rogério Brito <rbrito@ime.usp.br> escribió:

> Hi there. I'm seeing a really strange problem on my system lately and I
> am not really sure that it has anything to do with the kernels.


You don't say what filesystem are you using. Have you tried running fsck?
