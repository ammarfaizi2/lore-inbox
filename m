Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVAaW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVAaW7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVAaW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:59:06 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:34700 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261416AbVAaW7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:59:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=tk3uv7nlsJ5eC9j45rUCNubfNlnHdBi0ZgcqEM+olSXoGx+9N+w7y9vFrLl7xntsEBC6+s/O0Bxss3a3bw8QrJ3M7JTx3PmHg88o+lC93GaOD37o6xj6VrBW8Ylsh+k5bIoICi79tufjXVkwzjOm86KhnGM7zaWjwx7UD1tPEkc=
Message-ID: <5b64f7f0501311459320d503e@mail.gmail.com>
Date: Mon, 31 Jan 2005 17:59:03 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Benno <benjl@cse.unsw.edu.au>
Subject: Re: My System doesn't use swap!
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131115034.GA9571@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41FE1B4B.2060305@tiscali.de>
	 <200501311157.10932.mbuesch@freenet.de> <41FE2814.9030503@tiscali.de>
	 <20050131115034.GA9571@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 22:50:35 +1100, Benno <benjl@cse.unsw.edu.au> wrote:
> On Mon Jan 31, 2005 at 13:44:04 +0100, Matthias-Christian Ott wrote:
> >Ok maybe I wasn't able to read the /free/ output correctly, but why is
> >no swap used (more than 60% ram are used)?
> 
> Why would you want to use swap when you still have free RAM? The kernel
> isn't using swap because there is no need to.

2004 common VM thread: Why is my swap being used, I still have free RAM?
2005 common VM thread: Why is my swap not being used, I only have some free RAM?

Guess Linux is getting something right -- we can't please anyone!!!

-Rahul
