Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWHJMCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWHJMCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbWHJMCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:02:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:53677 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161193AbWHJMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:02:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g9HAp3M8XVqATwZ7Til957dUrOBkZBxjD4oe/XwenPbIbhZwr7vwsKhmMkXbysitMaNXHTxk4T+J+zXCmzbgDGQ15RHsAue/edydS+wjR+PZmo53Pz+4UFJI3jhEd77E8cOEp2W+EVNsnU+iz/OLexw6aqy5dJf00Vg9BE3jrII=
Message-ID: <9a8748490608100502wd9a097cwab80c662300020e8@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:02:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: locks_insert_block: removing duplicated lock (pid=2711 0-9223372036854775807 type=1)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a server running 2.6.11.11 that just reported the following in dmesg :

locks_insert_block: removing duplicated lock (pid=2711
0-9223372036854775807 type=1)

Should I worry?
Any info I can provide that would be useful?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
