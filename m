Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVEJSU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVEJSU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVEJSU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:20:59 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:41617 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261723AbVEJSUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:20:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sA6bMf7rtrUvYe8Ppbt2fglEWBTxYCM1eLaWm2s8nxttn6XSbHPrte5l57Sxl5DeKgPZUgjtmDT6kSo8baqymyNhfW6b2wyxpDa1VE5esv21QuHFXt0/G+hgFCFN0YqC11tbIvQ+ljRso1SCCJh5I3sNi7z/J4eGhKW75Twdg9E=
Message-ID: <d120d500050510112018b8a428@mail.gmail.com>
Date: Tue, 10 May 2005 13:20:55 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mitch <Mitch@0bits.com>
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4280F856.2080907@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4280F856.2080907@0Bits.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Mitch <Mitch@0bits.com> wrote:
> Still no go. Log attached.
> 

But I see a proper response (absolute packet) to the POLL command so
we are maiking progress I think. It looks like the touchpad was left
in disabled state somehow. Have you tried both the touchpad and
trackpoint? Are both of them dead?

-- 
Dmitry
