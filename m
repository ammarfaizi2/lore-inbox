Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbRCAQDf>; Thu, 1 Mar 2001 11:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129677AbRCAQDQ>; Thu, 1 Mar 2001 11:03:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53632 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129674AbRCAQDJ>; Thu, 1 Mar 2001 11:03:09 -0500
Date: Thu, 1 Mar 2001 11:02:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: kernel@kvack.org
cc: Ofer Fryman <ofer@shunra.co.il>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Intel-e1000 for Linux 2.0.36-pre14
In-Reply-To: <Pine.LNX.3.96.1010301102756.2411B-100000@kanga.kvack.org>
Message-ID: <Pine.LNX.3.95.1010301105321.12870A-101000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1295196120-1201726546-983462543=:12870"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1295196120-1201726546-983462543=:12870
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 1 Mar 2001 kernel@kvack.org wrote:

> On Thu, 1 Mar 2001, Ofer Fryman wrote:
> 
> > I managed to compiled e1000 for Linux 2.0.36-pre14, I can also load it
> > successfully. 
> > With the E1000_IMS_RXSEQ bit set in IMS_ENABLE_MASK I get endless interrupts
> > and the computer freezes, without this bit set it works but I cannot receive
> > or send anything.
> 
> Intel refuses to provide complete documentation for any of their ethernet
> cards.  I recommend purchasing alternative products from vendors like 3com
> and National Semiconduct who are cooperative in providing data needed by
> the development community.
> 

Well Intel has been a continual contributor to Linux and BSD. Somebody
is not getting to the right person. There are lazy people at all
companies. 

Here is a compressed `grep` of linux-kernel mail headers from Intel
who had something useful to say during the past year. Maybe you
can ask one of them for the information you need? You just need to
find an advocate at a big company.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


---1295196120-1201726546-983462543=:12870
Content-Type: APPLICATION/octet-stream; name="xxx.gzip"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.95.1010301110223.12870B@chaos.analogic.com>
Content-Description: 

H4sIAC1xnjoAA52WXW/iOBSGr3d+hYX2Yqolxl9J7ExVNRCYqTTVVLTavRj1
wgUDaUmCnECHf782AYZA+JhKIJsDPj7v8fM65HKhhk6i8lyOVR70dJaAROo3
ONZZnt/GaaGmcGCC4D5LQTjTAAuAecBwQLGZC/Epr6boq2KuU+dBFpOgNtXh
goGKTSQAI7v7RL0omGn4e+vPh6GfmDJo34RxyJ6vwMsSDCYyy6FM5TQbx4Ny
JYcC0haHPqRX4D0uJqD7eP/0AOIheAxDxJhHwSjT4FpnWXF7mOHmi9XdtKJL
7WKrHgEHMYTOqMl0nuS/CIevo11F9eGfWBCIPQ49FxL+fLWf+y+jsqY9ViSW
/8xwazVrmb21msolTFhzATD0bN28hXGLMEBIgFHgeiB+VzPQ/TUrJ3/vt+fB
tMfzhX9cnymmXsYq0Z35qFNVgHsZT8Gj0ot4oMBnFxpphBIoDtTdlxPnLgrA
NcIdzqhHXEZoRDAOO7SHUIg6whNdLhDCqEMxRbdlCdStlHCzn9tyHYDGV0ti
05Sk3xrgug7Og5VP2WUU2981onk6lbMm6Mt0uDQ7aDvC4Sp6Yo++Gimt0oGZ
guvI7QpKeq7Pu+0IV5S3cdfrIZe5Hc/3NsrxaeV7PI5lukzUcB+hip/oc8A4
EaDR/fb9xwGDtRkaKwcuxkpDPS/MkEM1nO8gdaasFXVrVyxyhB18whkI1Vvj
iLZz9iAEmJSohVgLGav4gcsDF4NhMhhIXawssnFH5e4wVH75mPu3any08rnt
3W7o1K3ycdcxc7TotOsExSKKesb2HVa6jvkb9vyOYAhzwruCrdlj5CLX9eVr
E4T5JLOmk3aEWr6e9EOli8VETmMJR8kesQQSSo0uH2L8HBAfM/8IszUZdoh9
sy2bGmrGfwrsKFkDSw2wlfq25ZkeEUTrga0Vdg5XSktc7XVun8BGuHmBPMmK
ifFdLa9PYUioR+k5Xks9WBzrtSEIizWvv0NG30le67Oe5dVzjRXwaWDPXpZ+
1I56HXThZbkG9uJrXKWFk5jKHTnTjj2V8jFwAfCHK+9Sp69m06VjU1zoRIaP
OnG7wUi9fLC06son9S513AT/xq/SNmVhR1isomfWV6X5bRp5fhhyvDkz8zdq
LY3Qno/cyMedntic2XFpr/PpB6VtV/551wX2wvNdz9Vsp7SvMk6V+ePR1qoo
wH+mvhc7g+9wvPqmvshtjr0iXeoaqDm3dDOMeZev++dGiLgYI+557dvSdcKv
uO7m0/+IV/dV8QsAAA==
---1295196120-1201726546-983462543=:12870--
