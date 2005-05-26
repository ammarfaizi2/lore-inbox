Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVEZSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEZSir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEZSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:38:46 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:55300 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261693AbVEZSik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:38:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BMs1sutUiIZxYojeBWTFxQYdtAIiLCZoz3eGt/raFX253o67/zI/dON1108W/DzQTsy3r8XjhTo90pl4+zMI8wLnLYP6jXdElC8UvFafLWiNdO080WwnfTfK3ckL/rYJj38Z6gyZR40eiIUeFsMKrcjuJwef9k+fXekVHRbl4oE=
Subject: Re: 2.6.12-rc5-mm1 alsa oops
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: Wolfgang Wander <wwc@rentec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4296100F.2090202@rentec.com>
References: <1117092768.26173.4.camel@localhost>
	 <4296100F.2090202@rentec.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 21:33:27 +0300
Message-Id: <1117132408.15499.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I reversed as mentioned here : http://lkml.org/lkml/2005/5/26/109

It's working like a charm now.

