Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWHUIMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWHUIMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWHUIMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:12:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:46608 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030344AbWHUIMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:12:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:content-transfer-encoding:from;
        b=Y099LaEeeu8nFdhyi9ia11fpJO5mLa2q9JavZ2CoS5yzWjRbFL+zn6j0N8t0w2wBDFNo7RWCBWTX2iiFSGn1GN5za+mnnzvOa9wznxVJSgA3rSYi6FJbl0HKgR6YKQLuJ5xOUA8knF6dPjBRIWY2W3GMwSnXNbUgFxjHyQZonYk=
Date: Mon, 21 Aug 2006 10:12:16 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-ID: <20060821081216.GA9194@gmail.com>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
X-Operating-System: Linux 2.6.18-rc3-mm2
User-Agent: Mutt/1.5.13 (2006-08-11)
Content-Transfer-Encoding: 8BIT
From: Gregoire Favre <gregoire.favre@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

like thunder7@xs4all.nl wrote :
"Also, it stil has the funny fast moving clock on x86-64"
As I already repported for 2.6.18.rc4-mm1 playing video too fast, I
suffer from the same problem.

I put under http://gregoire.favre.googlepages.com/linux all the config I
could think about in order to help find out where the problem came from.

I could add anything wanted, just CC to me as I am not under this ml.

Thank you very much,
-- 
Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
