Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSLVBAu>; Sat, 21 Dec 2002 20:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSLVBAu>; Sat, 21 Dec 2002 20:00:50 -0500
Received: from www2.mail.lycos.com ([209.202.220.150]:4920 "HELO mailcity.com")
	by vger.kernel.org with SMTP id <S264644AbSLVBAt>;
	Sat, 21 Dec 2002 20:00:49 -0500
To: "Rob Shortt" <rob@infointeractive.com>
Date: Sat, 21 Dec 2002 20:08:32 -0500
From: "Paul Richards" <greytek@lycos.com>
Message-ID: <CBLIEOOEMIICNBAA@mailcity.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: greytek@lycos.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: [PATCH] 2.4.19 rivafb updates
X-Sender-Ip: 68.41.210.181
Organization: Lycos Mail  (http://www.mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Dec 2002 11:06:07  
 Rob Shortt wrote:
>Hi Paul,
>
>First of all, thanks for this patch!  I came accross it while searching 
>the archives last night.  I am using a GeForce4 MX440 and have applied 
>your patch, now rivafb successfully detects my card.
>
>I am trying to use rivefb with my TV as the (only) display.  I have 
>tried an 800x600 mode @ 60 Hz which from what I read is optimal for 
>TV's, also this is the mode I use when using X to display on my TV. 
>With rivafb in this mode (similar results for other modes) my display is 
>totally garbled with rectangles of colours going everywhere.
>
>My question is does something need to change with regard to rivafb to 
>play nice with a television as the display or do I just need to keep 
>searching for a better modeline?  I will be testing the patched rivafb 
>this evening with a regular monitor to make sure that works as well.
>
>Once again, thanks!  If anyone else on this list has any input that also 
>would be appreciated.
>
>-Rob Shortt
>

Sorry for the wait (real life stuff), but unfortunately there is no tv-out support in this patch. 

Regards,

Paul F. Richards


_____________________________________________________________
Get 25MB, POP3, Spam Filtering with LYCOS MAIL PLUS for $19.95/year.
http://login.mail.lycos.com/brandPage.shtml?pageId=plus&ref=lmtplus
