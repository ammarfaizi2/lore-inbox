Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUAQEFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 23:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAQEFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 23:05:37 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:9571 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265982AbUAQEFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 23:05:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg Fitzgerald <gregf@bigtimegeeks.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
Date: Fri, 16 Jan 2004 23:05:26 -0500
User-Agent: KMail/1.5.4
References: <20040115225948.6b994a48.akpm@osdl.org> <20040117013115.GA5524@evilbint>
In-Reply-To: <20040117013115.GA5524@evilbint>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401162305.26269.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 January 2004 08:31 pm, Greg Fitzgerald wrote:
> Hi,
>
> 	Just gave 2.6.1-mm4 a try hoping to fix my NFS problems. NFS seems
> to be working better but now my mouse is not working properly. I have
> psmouse.psmouse_proto=exps in my grub.conf.
>

Please change it to psmouse.proto=exps

-- 
Dmitry
