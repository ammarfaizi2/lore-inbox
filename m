Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136769AbREAXkm>; Tue, 1 May 2001 19:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136773AbREAXke>; Tue, 1 May 2001 19:40:34 -0400
Received: from fjetret.sletner.com ([195.159.2.90]:19720 "HELO
	mail.sletner.com") by vger.kernel.org with SMTP id <S136769AbREAXk2>;
	Tue, 1 May 2001 19:40:28 -0400
Date: Wed, 2 May 2001 01:39:33 +0200
From: Stian Sletner <stian@sletner.com>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dead keys
Message-ID: <20010502013933.C17376@sletner.com>
In-Reply-To: <UTC200105012312.BAA61113.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <UTC200105012312.BAA61113.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, May 02, 2001 at 01:12:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* At 2001-05-02T01:12+0200, Andries.Brouwer@cwi.nl wrote:
: 
| The first line makes unadorned [no Shift, Ctrl, Alt] slash
| (on my keyboard the key with keytop / has keycode 53 as showkey tells me)
| into a dead ASCII slash. The 0d part is for "dead".

Well, if I had known this, I could've saved us all some time.  Sorry
about that, ignore the patch -- doesn't matter that the default is weird
when I can change it. :)  Thanks for the info.

-- 
Stian Sletner, gets to work on his keymap again
