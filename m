Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVCBW7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVCBW7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVCBW6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 17:58:47 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:35400 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261154AbVCBWzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 17:55:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=To/0PboM8i6yNoTNapFzfUXqEiWI//+Ee07pkoztkJT6StoeuxkuoDlqfnJQ3dQA3uZwoUynFLYsBL2UdIukOIJaTPEinoy4UklHa04WhzJfIutcNjimQlkIwmhKnMtFz5bK4jnA0B3STyRwObmAxhsafpgJxmCbmgEYEtRq134=
Message-ID: <d120d50005030214551146b1a3@mail.gmail.com>
Date: Wed, 2 Mar 2005 17:55:23 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFD: Kernel release numbering
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 14:21:38 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> Comments?
> 

Just rename:

2.<even>.<odd>-rcX  ->  2.<even>.y-preX
2.<even>.<odd>      ->  2.<even>.y-rcX
2.<even>.<even>     ->  2.<even>.y

-- 
Dmitry
