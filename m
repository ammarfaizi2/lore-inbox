Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVAJWSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVAJWSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVAJWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:14:04 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:36174 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262724AbVAJWJa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:09:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=A/pbv3cUscwIoFz9DNiwqtIe5x0Zoi3Borx0ZmjtwgmWMtD7OdERwWTacSLG6ZTP3+MB0aXU0K+UDJ4v5Alz9+bsMWwKKuYqIKK/9QJ0KXo142qsRnXK3IhwR3she/VM5JkyqlY2aa5H9ZE5B91BF7D+2yHOw199eAaKlAiT/1c=
Date: Mon, 10 Jan 2005 23:08:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security
 vulnerabilities?
Message-Id: <20050110230827.4d13ae7b.diegocg@gmail.com>
In-Reply-To: <41E2F6B3.9060008@rueb.com>
References: <41E2B181.3060009@rueb.com>
	<87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 10 Jan 2005 15:42:11 -0600 Steve Bergman <steve@rueb.com> escribió:

> Actually I am having a discussion with a Pax Team member about how the 
> recent exploits discovered by the grsecurity guys should have been 
> handled.  They clam that they sent email to Linus and Andrew and did not 
> receive a response for 3 weeks, and that is why they released exploit 
> code into the wild.


They could have mailed to *THIS* mailing list, so anyone can make a patch.
