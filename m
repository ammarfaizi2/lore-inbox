Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVDDQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVDDQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDDQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 12:57:04 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:50181 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261284AbVDDQyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 12:54:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kh282l3DlC2XXvIg8XUXoZPM392dmqbm2/Cst0rCB8HS97Xq9M287VdK6GsfvoR7P7eX+tiaDl2eIdm+0fWKJPUPtyDMrhSbfvZtmunMAugTOZVULHjfFlALsk84BfsueCAMx+j3Ew+Qe+9EkBJa9fUrcW142YL6p0w1Pogpwd8=
Message-ID: <d120d5000504040954354fb3fa@mail.gmail.com>
Date: Mon, 4 Apr 2005 11:54:51 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <425166F9.1040800@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Apr 4, 2005 11:10 AM, Jaco Kroon <jaco@kroon.co.za> wrote:
> Hello all
> 
> A while back there was quite a discussion on this issue and then
> specifically "i8042 timing issues".  I refer you to
> http://lkml.org/lkml/2005/1/27/11 for more detail.
...

I was under impression that "usb-handoff" kernel parameter fixed the
problem and therefore the patch is not needed. Am I wrong?

-- 
Dmitry
