Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVBRUAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVBRUAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVBRUAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:00:25 -0500
Received: from simmts5.bellnexxia.net ([206.47.199.163]:28371 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261468AbVBRUAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:00:15 -0500
Message-ID: <3920.10.10.10.24.1108756671.squirrel@linux1>
In-Reply-To: <d120d5000502181149670d27c0@mail.gmail.com>
References: <seanlkml@sympatico.ca><4912.10.10.10.24.1108675441.squirrel@linux1><200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl><1451.10.10.10.24.1108713140.squirrel@linux1><20050218162729.GA5839@thunk.org><4075.10.10.10.24.1108751663.squirrel@linux1><d120d50005021811263c40f683@mail.gmail.com><3369.10.10.10.24.1108755080.squirrel@linux1>
    <d120d5000502181149670d27c0@mail.gmail.com>
Date: Fri, 18 Feb 2005 14:57:51 -0500 (EST)
Subject: Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: dtor_core@ameritech.net
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Chris Friesen" <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, February 18, 2005 2:49 pm, Dmitry Torokhov said:

> You from cvs you can import into other SCM of your choise.

This isn't true unfortunately, a lot of information is lost in cvs.  file
deletes, renames etc..   Plus, the implementation from Bitkeeper is
lacking, (eg. combining many changes into one).

>
> Heh, you don't get to update the master repository even if you are
> using BK.  And you are free to update your local tree with
> CVS/SVN/whatever. So I am not sure why you trying this argument.

Yeah,  I didn't mean to suggest that it be opened up to the public :o) 
Just that the flow of information wouldn't all have to originate in bk to
make it into head (ie. bk could pull changes from head too).

Cheers,
Sean.

