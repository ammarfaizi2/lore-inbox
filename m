Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWDZVrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWDZVrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWDZVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:47:48 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:45263 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964894AbWDZVrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:47:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=TAGdrHjeMdAu/73iEJL5nfgzucebDtBXk5vkSgoU61yPKlXC20KAE7bZl6S3xC4QvqFZSatay/EDq5vZNNVksUT/oXgYikHhhdGRRqMQRBu7HtA7LP6Iso1+g2U14QNWoJf+TTH77M7LqbLqd2ZSyz/hs/qVd0sWj6ckehmumTU=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Daniel Walker'" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
Subject: RE: [PATCH] Profile likely/unlikely macros -v2
Date: Wed, 26 Apr 2006 14:47:44 -0700
Message-ID: <00d901c6697b$0e14dce0$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <200604262145.k3QLjixA005676@dwalker1.mvista.com>
Thread-Index: AcZpesd276CJTmCbQEm3cyjKP58k9QAADPxw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes are switched to test_and_set_bit()/clear_bit() , 
> comment explaining test_and_set_bit(), and most every other comment ..
> 
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Thanks Daniel.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

