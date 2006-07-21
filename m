Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWGUKeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWGUKeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 06:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWGUKeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 06:34:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:39015 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161021AbWGUKeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 06:34:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dXFLIwHeFHus2wiYbOohohHsDQI5tEzmR8wDohFpFfVoGgJji6RfL01SDuVHwAMDyp2S+wJakuxE4u/wfX246C5kM5brSMKGRJBJYNTWpPJWjg6SqdhNI77/wxzVIuI9xJgOxvXah4RErFwM5ygoWbNSACsB3EdHxbj0qAkrCNg=
Message-ID: <84144f020607210334r6f3cf142r839dae89fdc01825@mail.gmail.com>
Date: Fri, 21 Jul 2006 13:34:06 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Arthur Othieno" <apgo@patchbomb.org>
Subject: Re: [PATCH] doc: pci_module_init() removal
Cc: gregkh@suse.de, "Richard Knutsson" <ricknu-0@student.ltu.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020607210332l2ecf4c7ch7fe144e2d8c7764d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719234044.GB8584@krypton>
	 <84144f020607210332l2ecf4c7ch7fe144e2d8c7764d@mail.gmail.com>
X-Google-Sender-Auth: 7e517775adfdf18e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Arthur Othieno <apgo@patchbomb.org> wrote:
> > -This API replaces the Linux Driver Model's pci_module_init API. A
> > +This API replaces the Linux Driver Model's pci_register_driver API. A

On 7/21/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> This doesn't look right.

Oh, it's just me being confused. Sorry for the noise.
